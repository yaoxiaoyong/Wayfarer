name := """Wayfarer-backend"""

version := "1.0-SNAPSHOT"

lazy val root = (project in file(".")).enablePlugins(PlayJava)

scalaVersion := "2.11.1"

libraryDependencies ++= Seq(
  javaJdbc,
  cache,
  javaJpa,
  "org.postgresql" % "postgresql" % "9.3-1102-jdbc4",
  "org.hibernate" % "hibernate-entitymanager" % "4.2.17.Final"
)

libraryDependencies += "xalan" % "serializer" % "2.7.2"
