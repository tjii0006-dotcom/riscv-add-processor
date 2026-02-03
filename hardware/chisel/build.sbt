name := "riscv-add-processor"
version := "0.1.0"
scalaVersion := "2.13.8"

lazy val root = (project in file("."))
  .settings(
    libraryDependencies ++= Seq(
      "edu.berkeley.cs" %% "chisel3" % "3.5.6",
      "edu.berkeley.cs" %% "chiseltest" % "0.5.6" % "test",
      "org.scalatest" %% "scalatest" % "3.2.12" % "test"
    ),
    addCompilerPlugin("edu.berkeley.cs" % "chisel3-plugin" % "3.5.6" cross CrossVersion.full)
  )
