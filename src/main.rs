#[macro_use]
extern crate rust_embed;

use std::fs::File;
use std::io::{Seek, Write};

use argparse::{ArgumentParser, Store};
use zip::result::ZipResult;
use zip::write::FileOptions;
use zip::ZipWriter;

#[derive(RustEmbed)]
#[folder = "datapack"]
struct Asset;

const DEFAULT_X: i32 = 20000;
const DEFAULT_Y: i32 = 100;
const DEFAULT_Z: i32 = 1000;
const DEFAULT_R: i32 = 300;
const DEFAULT_OUT_FILE: &str = "creative_zone.zip";

fn main() {
    let mut x = DEFAULT_X;
    let mut y = DEFAULT_Y;
    let mut z = DEFAULT_Z;
    let mut r = DEFAULT_R;

    let help_x = format!("The x position of the creative zone. [Default: {}]", DEFAULT_X);
    let help_y = format!("The y position of the creative zone. [Default: {}]", DEFAULT_Y);
    let help_z = format!("The z position of the creative zone. [Default: {}]", DEFAULT_Z);
    let help_r = format!("The radius of the creative zone. [Default: {}]", DEFAULT_R);

    {  // this block limits scope of borrows by ap.refer() method
        let mut ap = ArgumentParser::new();
        ap.set_description("Create a minecraft datapack for custom creative zone.");
        ap.refer(&mut x)
            .add_option(&["-x"], Store,
                        &help_x);
        ap.refer(&mut y)
            .add_option(&["-y"], Store,
                        &help_y);
        ap.refer(&mut z)
            .add_option(&["-z"], Store,
                        &help_z);
        ap.refer(&mut r)
            .add_option(&["-r"], Store,
                        &help_r);
        ap.parse_args_or_exit();
    }

    let ro = r + 100;

    let mut file = File::create(DEFAULT_OUT_FILE).expect("Couldn't create file!");
    create_zip_archive(&mut file, x, y, z, r, ro).expect("Couldn't create archive");
}

fn create_zip_archive<T: Seek + Write>(buf: &mut T, x: i32, y: i32, z: i32, r: i32, ro: i32) -> ZipResult<()> {
    let mut writer = ZipWriter::new(buf);
    for file in Asset::iter() {
        writer.start_file(&file.to_string(), FileOptions::default())?;
        let mut content = std::str::from_utf8(Asset::get(&file).unwrap().as_ref()).unwrap().to_owned();
        content = content.replace("||X_POS||", &format!("{}", x));
        content = content.replace("||Y_POS||", &format!("{}", y));
        content = content.replace("||Z_POS||", &format!("{}", z));
        content = content.replace("||RADIUS||", &format!("{}", r));
        content = content.replace("||RADIUS_OUTER||", &format!("{}", ro));
        writer.write(content.as_bytes())?;
    }
    writer.finish()?;
    Ok(())
}
