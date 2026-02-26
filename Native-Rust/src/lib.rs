use std::ffi::{CStr, CString};
use std::os::raw::c_char;
use std::panic;

#[unsafe(no_mangle)]
pub extern "C" fn fetch_api_post_json(url: *const c_char, data_json: *const c_char) -> *mut c_char {
    if url.is_null() || data_json.is_null() {
        return std::ptr::null_mut();
    }

    let client = reqwest::blocking::Client::new();
    let c_str_data_json = unsafe {
        CStr::from_ptr(data_json)
    };
    let data_json_str = match c_str_data_json.to_str() {
        Ok(s) => s,
        Err(_) => return std::ptr::null_mut(),
    };
    
    let c_str_url = unsafe {
        CStr::from_ptr(url)
    };
    let url_str = match c_str_url.to_str() {
        Ok(s) => s,
        Err(_) => return std::ptr::null_mut(),
    };

    let mut headers = reqwest::header::HeaderMap::new();
    headers.insert("User-Agent", reqwest::header::HeaderValue::from_static("Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36"));
    headers.insert("content-type", reqwest::header::HeaderValue::from_static("application/json"));

    let response = match client.post(url_str).headers(headers).body(data_json_str).send() {
        Ok(resp) => match resp.text() {
            Ok(text) => text,
            Err(_) => "Error read".to_string(),
        },
        Err(_) => "Error read".to_string(),
    };

    match CString::new(response) {
        Ok(c) => c.into_raw(),
        Err(_) => CString::new("Error: Internal null byte in response").unwrap().into_raw(),
    }
}

#[unsafe(no_mangle)]
pub extern "C" fn fetch_api_get(url: *const c_char) -> *mut c_char {
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
        let _ = CString::from_raw(ptr);
    }
}

#[unsafe(no_mangle)]
pub extern "C" fn testing() -> *mut c_char {
    let result = panic::catch_unwind(|| {
        let c_url_str = CString::new("https://github.com/SyntxFlow").unwrap();
        let url_str = c_url_str.to_str().unwrap();
    
        let _ = match reqwest::blocking::get(url_str) {
            Ok(resp) => match resp.text() {
                Ok(s) => s,
                Err(_) => "Read Error".to_string(),
            },
            Err(_) => "Read Error".to_string(),
        };
    
        CString::new("Testing content html page").unwrap()
    });

    match result {
        Ok(c) => c.into_raw(),
        Err(err) => {
            let msg = if let Some(s) = err.downcast_ref::<&str>() {
                format!("panic: {}", s)
            } else if let Some(s) = err.downcast_ref::<String>() {
                format!("panic: {}", s)
            } else {
                "panic: unknown".to_string()
            };

            CString::new(msg).unwrap().into_raw()
        },
    }
}

#[cfg(test)]
mod tests {
    use super::*;
    use std::ffi::CString;
    use std::ptr;

    #[test]
    fn test_null_pointer() {
        let result = fetch_api_get(ptr::null());
        assert!(result.is_null());
    }

    #[test]
    fn test_valid_url() {
        let url = CString::new("https://github.com/SyntxFlow").unwrap();

        let result_ptr = fetch_api_get(url.as_ptr());
        assert!(!result_ptr.is_null());

        unsafe {
            let result_str = CStr::from_ptr(result_ptr).to_str().unwrap();

            assert!(result_str.contains("SyntxFlow"));
        }

        free_string(result_ptr);
    }

    #[derive(serde::Serialize)]
    struct Payload {
        url: String,
        is_mp3_page: bool,
    }

    #[test]
    fn test_valid_json_post() {
        let url = CString::new("https://ttdl.cc/api/extract").unwrap();
        let payload = Payload {
            url: "https://www.tiktok.com/@wesessewes/video/7609597607232523528?is_from_webapp=1&sender_device=pc".to_string(),
            is_mp3_page: false,
        };

        let str_json = CString::new(serde_json::to_string(&payload).unwrap()).unwrap();

        let result_ptr = fetch_api_post_json(url.as_ptr(), str_json.as_ptr());
        assert!(!result_ptr.is_null());

        unsafe {
            let result_str = CStr::from_ptr(result_ptr).to_str().unwrap();

            println!("{result_str}");

            assert!(result_str.contains("wesessewes"));
        }

        free_string(result_ptr);
    }

    #[test]
    fn test_testing() {
        let ptr_response = testing();
        let c_response = unsafe { CStr::from_ptr(ptr_response) };
        let str_response = c_response.to_str().unwrap();

        println!("{str_response}");

        assert!(str_response.contains("SyntxFlow"));

        free_string(ptr_response);
    }
}