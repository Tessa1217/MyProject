package egovframework.fusion.chat;

import org.apache.tiles.request.ApplicationContext;
import org.apache.tiles.request.ApplicationContextAware;
import org.springframework.stereotype.Component;

@Component
public class CTXProvider implements ApplicationContextAware {
	
	public static ApplicationContext ctx;
	
	@Override
	public void setApplicationContext(ApplicationContext applicationContext) {
		this.ctx = applicationContext;
	}
	
	
}
