package egovframework.fusion.user.vo;

import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

import egovframework.fusion.user.vo.UserAuth.Role;

@Retention(RetentionPolicy.RUNTIME)
@Target(ElementType.METHOD)
public @interface UserAuth {
	
	Role[] role() default Role.USER;
	
	enum Role {
		USER,
		MEMBER,
		ADMIN,
		SUPERADMIN
	}
	
}
