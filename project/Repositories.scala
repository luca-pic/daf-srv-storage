import sbt._
import Environment._
import sbt.Keys.isSnapshot

object Repositories {

  def publish: Def.Initialize[Option[Resolver]] = isSnapshot {
    case true  => Some { "snapshots" at s"$nexusUrl/maven-snapshots/" }
    case false => Some { "releases"  at s"$nexusUrl/maven-releases/"  }
  }

  def credential = Credentials { Path.userHome / ".ivy2" / ".credentials" }

}
