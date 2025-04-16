allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

// Ajoute cette section pour définir les référentiels nécessaires pour résoudre les dépendances
buildscript {
    repositories {
        google()  // Référentiel pour les outils Android (plugin Gradle)
        mavenCentral()  // Repositorio Maven Central pour d'autres dépendances
    }
    dependencies {
        // Ajoute ici le plugin Android Gradle avec la version que tu souhaites utiliser
        classpath("com.android.tools.build:gradle:8.1.0")
    }
}

val newBuildDir: Directory = rootProject.layout.buildDirectory.dir("../../build").get()
rootProject.layout.buildDirectory.value(newBuildDir)

subprojects {
    val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
    project.layout.buildDirectory.value(newSubprojectBuildDir)
}

subprojects {
    project.evaluationDependsOn(":app")
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}
