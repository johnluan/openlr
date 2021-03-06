CREATE TABLE LINE (
	ID bigint PRIMARY KEY NOT NULL,
	START_NODE_ID bigint NOT NULL,
	END_NODE_ID bigint NOT NULL,
	DISPLAY_NAME varchar(255),
	DISPLAY_NAME_LANGCODE varchar(3) NOT NULL DEFAULT 'UND',
	FOW tinyint NOT NULL CHECK(FOW BETWEEN 0 AND 7),
	FRC tinyint NOT NULL CHECK(FRC BETWEEN 0 AND 7),
	LENGTH_METERS double NOT NULL CHECK (LENGTH_METERS > 0),
	MIN_LONGITUDE double NOT NULL CHECK (MIN_LONGITUDE >= -180),
	MAX_LONGITUDE double NOT NULL CHECK (MAX_LONGITUDE <= 180),
	MIN_LATITUDE double NOT NULL CHECK (MIN_LATITUDE >= -90),
	MAX_LATITUDE double NOT NULL CHECK (MAX_LATITUDE <= 90),
	GEOM blob NOT NULL,
	FOREIGN KEY (END_NODE_ID) REFERENCES NODE(ID),
	FOREIGN KEY (START_NODE_ID) REFERENCES NODE(ID)
);

CREATE TABLE NODE (
	ID bigint PRIMARY KEY NOT NULL,
	LONGITUDE double NOT NULL CHECK(LONGITUDE >= -180 AND LONGITUDE <= 180),
	LATITUDE  double NOT NULL CHECK(LATITUDE >= -90 AND LATITUDE <= 90)
);

CREATE TABLE METADATA (
	MAP_NAME varchar(64) NOT NULL,
	MAP_RELEASE varchar(8) NOT NULL,
	MAP_COMPILE_DATE datetime NOT NULL,
	MAP_COPYRIGHT_OWNER varchar(64) NOT NULL,
	MIN_LONGITUDE double NOT NULL,
	MIN_LATITUDE double NOT NULL,
	MAX_LONGITUDE double NOT NULL,
	MAX_LATITUDE double NOT NULL
);

CREATE INDEX LINE_IDX_SNID ON LINE(START_NODE_ID);
CREATE INDEX LINE_IDX_ENID ON LINE(END_NODE_ID);
CREATE INDEX LINE_IDX_SIDX ON LINE(MIN_LONGITUDE, MIN_LATITUDE, MAX_LONGITUDE, MAX_LATITUDE);
CREATE INDEX NODE_IDX_SIDX ON NODE (LONGITUDE, LATITUDE);
