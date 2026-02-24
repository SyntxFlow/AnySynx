use std::ffi::{CString, CStr};
use std::os::raw::c_char;

#[unsafe(no_mangle)]
pub extern "C" fn fetch_api(url: *const c_char) -> *mut c_char {
    if url.is_null() {
        return std::ptr::null_mut();
    }

    let c_str = unsafe { CStr::from_ptr(url) };
    let url_str = match c_str.to_str() {
        Ok(s) => s,
        Err(_) => return std::ptr::null_mut(),
    };

    let response = match reqwest::blocking::get(url_str) {
        Ok(resp) => match resp.text() {
            Ok(text) => text,
            Err(_) => "error: read".to_string(),
        },
        Err(_) => "error: request".to_string(),
    };

    let c_string = CString::new(response).unwrap();
    c_string.into_raw()
}

#[unsafe(no_mangle)]
pub extern "C" fn free_string(ptr: *mut c_char) {
    if ptr.is_null() {
        return;
    }
    unsafe {
        CString::from_raw(ptr);
    }
}