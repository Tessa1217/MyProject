DROP TABLE BOARD_USER_AUTH;
CREATE TABLE BOARD_USER_AUTH (
	USER_AUTH_CODE CHAR(5),
	USER_AUTH_DESC VARCHAR2(200),
	CONSTRAINT BOARD_USER_AUTH_PK PRIMARY KEY (USER_AUTH_CODE)
);

DROP TABLE BOARD_USER;
CREATE TABLE BOARD_USER (
	USER_NO NUMBER(15),
	USER_ID VARCHAR2(40) NOT NULL,
	USER_PASSWORD VARCHAR2(200) NOT NULL,
	USER_NAME VARCHAR2(40) NOT NULL,
	USER_AUTH CHAR(5) DEFAULT 'USERS',
	CONSTRAINT BOARD_USER_PK PRIMARY KEY (USER_NO),
	CONSTRAINT BAORD_USER_AUTH_FK FOREIGN KEY (USER_AUTH) REFERENCES BOARD_USER_AUTH (USER_AUTH_CODE)
);

DROP TABLE BOARD_TYPE;
CREATE TABLE BOARD_TYPE (
	BOARD_TYPE_NO NUMBER(1),
	BOARD_TYPE_DESC VARCHAR2(200),
	CONSTRAINT BOARD_TYPE_PK PRIMARY KEY (BOARD_TYPE_NO)
);

DROP TABLE BOARD;
CREATE TABLE BOARD (
	BOARD_NO NUMBER(19),
	USER_NO NUMBER(15) NOT NULL,
	BOARD_TYPE_NO NUMBER(1) NOT NULL,
	BOARD_TITLE VARCHAR2(400) NOT NULL,
	BOARD_CONTENT CLOB,
	BOARD_VIEW_CNT NUMBER DEFAULT 0,
	BOARD_REG_DATE TIMESTAMP DEFAULT SYSTIMESTAMP,
	BOARD_MOD_DATE TIMESTAMP DEFAULT SYSTIMESTAMP,
	BOARD_DELYN CHAR(1) DEFAULT 'N',
	BOARD_PARENT_NO NUMBER(19),
	BOARD_POPUPYN CHAR(1) DEFAULT 'N',
	CONSTRAINT BOARD_PK PRIMARY KEY (BOARD_NO),
	CONSTRAINT BOARD_USER_FK FOREIGN KEY (USER_NO) REFERENCES BOARD_USER(USER_NO),
	CONSTRAINT BOARD_TYPE_FK FOREIGN KEY (BOARD_TYPE_NO) REFERENCES BOARD_TYPE(BOARD_TYPE_NO),
	CONSTRAINT BOARD_DELYN_CHK CHECK (BOARD_DELYN IN ('N', 'Y')),
	CONSTRAINT BOARD_POPUPYN_CHK CHECK (BOARD_POPUPYN IN ('N', 'Y'))
);

DROP TABLE BOARD_COMMENT;
CREATE TABLE BOARD_COMMENT (
	COMMENT_NO NUMBER(19),
	BOARD_NO NUMBER(19),
	USER_NO NUMBER(15),
	COMMENT_CONTENT VARCHAR2(4000),
	COMMENT_REG_DATE TIMESTAMP DEFAULT SYSTIMESTAMP,
	COMMENT_MOD_DATE TIMESTAMP DEFAULT SYSTIMESTAMP,
	COMMENT_DELYN CHAR(1) DEFAULT 'N',
	COMMENT_PARENT_NO NUMBER(19),
	CONSTRAINT COMMENT_PK PRIMARY KEY (COMMENT_NO),
	CONSTRAINT COMMENT_BOARD_FK FOREIGN KEY (BOARD_NO) REFERENCES BOARD (BOARD_NO),
	CONSTRAINT COMMENT_USER_FK FOREIGN KEY (USER_NO) REFERENCES BOARD_USER (USER_NO),
	CONSTRAINT COMMENT_DELYN_CHK CHECK (COMMENT_DELYN IN ('N', 'Y'))
);

DROP TABLE BOARD_HISTORY;
CREATE TABLE BOARD_HISTORY (
	VISIT_DATE TIMESTAMP DEFAULT SYSTIMESTAMP,
	VISIT_BOARD_NO NUMBER(19),
	VISIT_USER_NO NUMBER(15),
	CONSTRAINT BOARD_HISTORY_PK PRIMARY KEY (VISIT_DATE, VISIT_USER_NO, VISIT_BOARD_NO),
	CONSTRAINT HISTORY_BOARD_FK FOREIGN KEY (VISIT_BOARD_NO) REFERENCES BOARD (BOARD_NO),
	CONSTRAINT HISTORY_USER_FK FOREIGN KEY (VISIT_USER_NO) REFERENCES BOARD_USER (USER_NO)
);

DROP TABLE BOARD_LIKES;
CREATE TABLE BOARD_LIKES (
	LIKES_USER_NO NUMBER(15),
	LIKES_BOARD_NO NUMBER(19),
	CONSTRAINT BOARD_LIKES_PK PRIMARY KEY (LIKES_USER_NO, LIKES_BOARD_NO),
	CONSTRAINT LIKES_USER_FK FOREIGN KEY (LIKES_USER_NO) REFERENCES BOARD_USER (USER_NO),
	CONSTRAINT LIKES_BOARD_FK FOREIGN KEY (LIKES_BOARD_NO) REFERENCES BOARD (BOARD_NO)
);

DROP TABLE BOARD_FILE;
CREATE TABLE BOARD_FILE (
	FILE_NO NUMBER(20),
	BOARD_NO NUMBER(19),
	FILE_ORI_NAME VARCHAR2(500),
	FILE_STORED_NAME VARCHAR2(1000),
	FILE_PATH VARCHAR2(2000),
	FILE_EXTENSION VARCHAR2(200),
	FILE_SIZE NUMBER(6) ,
	FILE_REG_DATE TIMESTAMP DEFAULT SYSTIMESTAMP,
	FILE_ORDER NUMBER(1),
	FILE_DELYN CHAR(1) DEFAULT 'N',
	FILE_DOWN_CNT NUMBER(20) DEFAULT 0,
	THUNBNAIL_PATH VARCHAR2(2000),
	CONSTRAINT BOARD_FILE_PK PRIMARY KEY (FILE_NO),
	CONSTRAINT FILE_BOARD_FK FOREIGN KEY (BOARD_NO) REFERENCES BOARD (BOARD_NO),
	CONSTRAINT FILE_ORDER_CHK CHECK (FILE_ORDER BETWEEN 1 AND 5),
	CONSTRAINT FILE_DELYN CHECK (FILE_DELYN IN ('N', 'Y'))
);

DROP TABLE BOARD_TAG;
CREATE TABLE BOARD_TAG (
	TAG_NO NUMBER(20),
	BOARD_NO NUMBER(19),
	TAG_CONTENT VARCHAR2(400),
	TAG_ORDER NUMBER(1),
	CONSTRAINT TAG_NO PRIMARY KEY (TAG_NO),
	CONSTRAINT TAG_BOARD_FK FOREIGN KEY (BOARD_NO) REFERENCES BOARD (BOARD_NO),
	CONSTRAINT TAG_ORDER_CHK CHECK (TAG_ORDER BETWEEN 1 AND 5)
);



