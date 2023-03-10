package egovframework.fusion.cmmn.web;

import java.util.HashMap;
import java.util.Map;

import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestController;

@ControllerAdvice
@RestController
public class GlobalExceptionHandler {
	
	@ExceptionHandler(value = Exception.class)
	public Map<String, String> handleException(Exception e) {
		Map<String, String> map = new HashMap<>();
		map.put("errMsg", e.getMessage());
		return map;
	}
}
