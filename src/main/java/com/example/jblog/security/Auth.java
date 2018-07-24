package com.example.jblog.security;

import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

@Target({ElementType.METHOD,ElementType.TYPE}) // 이 어노테이션은 메소드와 클래스(타입)에 적용하겠다.
@Retention( RetentionPolicy.RUNTIME) // 런타임시까지만 어노테이션을 유지하겠다.
public @interface Auth { // Auth는 커스텀 어노테이션
	
}
