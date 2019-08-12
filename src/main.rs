#[macro_use]
extern crate rust_embed;

use std::fs::File;
use std::io::{Seek, Write};

use clap::{App, AppSettings, Arg};
use zip::result::ZipResult;
use zip::write::FileOptions;
use zip::ZipWriter;

#[derive(RustEmbed)]
#[folder = "datapack"]
struct Asset;

const DEFAULT_R: u16 = 300;
const DEFAULT_TZ: u16 = 100;
const DEFAULT_OUT_FILE: &str = "creative_zone.zip";

fn main() {
    let default_r_string = format!("{}", DEFAULT_R);
    let default_tz_string = format!("{}", DEFAULT_TZ);

    let matches = App::new("Creative Zone Builder")
        .version("1.1.2")
        .setting(AppSettings::AllowNegativeNumbers)
        .setting(AppSettings::DeriveDisplayOrder)
        .about("Create a custom datapack for a creative zone in minecraft.")
        .arg(Arg::with_name("r")
            .help("The radius of the creative zone")
            .short("r")
            .long("radius")
            .takes_value(true)
            .default_value(&default_r_string)
            .display_order(0))
        .arg(Arg::with_name("tz")
            .help("The width of the teleport zone")
            .short("t")
            .long("teleport-zone-width")
            .takes_value(true)
            .default_value(&default_tz_string)
            .display_order(1))
        .arg(Arg::with_name("x")
            .help("The x position of the creative zone.")
            .required(true))
        .arg(Arg::with_name("y")
            .help("The y position of the creative zone.")
            .required(true))
        .arg(Arg::with_name("z")
            .help("The z position of the creative zone.")
            .required(true))
        .get_matches();

    let x = matches.value_of("x").expect("X coordinate is missing!").parse().expect("Invalid value for X coordinate!");
    let y = matches.value_of("y").expect("Y coordinate is missing!").parse().expect("Invalid value for Y coordinate!");
    let z = matches.value_of("z").expect("Z coordinate is missing!").parse().expect("Invalid value for Z coordinate!");

    let mut r = matches.value_of("r").unwrap_or(&default_r_string).parse().expect("Invalid value for radius!");
    let mut tz = matches.value_of("tz").unwrap_or(&default_tz_string).parse().expect("Invalid value for teleport zone width!");

    if tz == 0 {
        tz = DEFAULT_TZ;
    }

    if r == 0 {
        r = DEFAULT_R;
    }

    let ro = r + tz;

    println!("Creating creative zone at [x: {}, y: {}, z: {}]!", x, y, z);
    println!("Teleport zone starts at radius {} and ends at radius {}.", r, ro);

    let mut file = File::create(DEFAULT_OUT_FILE).expect("Couldn't create file!");
    create_zip_archive(&mut file, x, y, z, r as i32, ro as i32).expect("Couldn't create archive");

    println!("Written datapack to file: {}", DEFAULT_OUT_FILE);
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
