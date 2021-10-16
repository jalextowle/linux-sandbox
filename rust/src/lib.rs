#[cfg(test)]
mod tests {
    extern crate libc;
    use libc::size_t;

    #[link(name = "snappy")]
    extern "C" {
        fn snappy_max_compressed_length(source_length: size_t) -> size_t;
    }

    #[test]
    fn test_snappy_max_compressed() {
        let x = unsafe { snappy_max_compressed_length(100) };
        println!("max compressed length of a 100 byte buffer: {}", x);
    }
}
