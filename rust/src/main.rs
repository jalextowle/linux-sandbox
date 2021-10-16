extern crate libc;
use libc::size_t;

enum SnappyStatus {
    SnappyOk,
    SnappyInvalidInput,
    SnappyBufferTooSmall,
}

#[link(name = "snappy")]
extern "C" {
    fn snappy_max_compressed_length(source_length: size_t) -> size_t;

    fn snappy_compress(
        input: &[char],
        input_length: size_t,
        compressed_ptr: &mut [char],
        compressed_length: size_t,
    ) -> size_t;
}

fn main() {
    let x = unsafe { snappy_max_compressed_length(100) };
    println!("max compressed length of a 100 byte buffer: {}", x);

    let status =
}
