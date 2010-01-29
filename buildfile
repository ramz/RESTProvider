require File.join(File.dirname(__FILE__), 'android')

ENV['JAVA_HOME'] ||= '/usr/lib/jvm/java-6-sun'

# Generated by Buildr 1.3.5, change to your liking
# Version number for this release
VERSION_NUMBER = "0.0.1"
# Group identifier for your projects
GROUP = "RESTProvider"
COPYRIGHT = "Novoda ltd"
LICENSE = "Apache"

# Specify Maven 2.0 remote repositories here, like this:
repositories.remote << "http://www.ibiblio.org/maven2/"
repositories.remote << "http://oss.sonatype.org/content/repositories/signpost-releases"
repositories.remote << "http://repository.codehaus.org/org/codehaus/jackson/"

JACKSON = ['org.codehaus.jackson:jackson-core-asl:jar:1.4.0', 'org.codehaus.jackson:jackson-mapper-asl:jar:1.4.0']
SIGNPOST = ['oauth.signpost:signpost-core:jar:1.1', 'oauth.signpost:signpost-commonshttp4:jar:1.1']
DOM4J = ['dom4j:dom4j:jar:1.6.1']
DROIDFU = ["droidfu:droidfu:jar:1.0-SNAPSHOT"]

android_layout = Layout.new
android_layout[:source, :main, :java] = 'src'
android_layout[:target, :main] = 'bin'

desc "The Restprovider project"
define "RESTProviderAll", :layout => android_layout do

  project.version = VERSION_NUMBER
  project.group = GROUP
  manifest["Implementation-Vendor"] = COPYRIGHT
  compile.options.target = '1.5'
  eclipse.natures :android

  define "RESTProvider" do
    project.compile.sources << _('gen')
	  url = "http://cloud.github.com/downloads/kaeppler/droid-fu/droid-fu-1.0-SNAPSHOT.jar"
	  download(artifact("droidfu:droidfu:jar:1.0-SNAPSHOT") =>url)
  	compile.with SIGNPOST, JACKSON, DOM4J, DROIDFU, File.expand_path('android.jar', ENV['ANDROID_HOME'] + "/platforms/android-2.0")
    eclipse.exclude_libs = [File.expand_path('android.jar', ENV['ANDROID_HOME'] + "/platforms/android-2.0")]
	  package :jar, :id => 'RESTProvider'
  end

  #define "RESTProviderLocalTest" do
  #end

  define "RESTProviderTest" do
    project.compile.sources << _('gen')
	  url = "http://cloud.github.com/downloads/kaeppler/droid-fu/droid-fu-1.0-SNAPSHOT.jar"
	  download(artifact("droidfu:droidfu:jar:1.0-SNAPSHOT") =>url)
  	compile.with SIGNPOST, JACKSON, DOM4J, DROIDFU, File.expand_path('android.jar', ENV['ANDROID_HOME'] + "/platforms/android-2.0"), project('RESTProvider')
    eclipse.external_sources = project('RESTProvider')
    eclipse.exclude_libs = [File.expand_path('android.jar', ENV['ANDROID_HOME'] + "/platforms/android-2.0")]
  end

end