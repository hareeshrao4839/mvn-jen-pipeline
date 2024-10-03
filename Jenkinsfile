pipeline {

    environtment {
       def serviceName= "sim"
       def reg= "drop1"
    }
  agent any
  stages {
      stage('Build Artifact') {
            steps {
              sh "mvn clean package -DskipTests=true"
              archive 'target/*.jar' 
            }  
       }
      stage('Test Maven - JUnit') {
            steps {
              sh "mvn test"
            }
            post{
              always{
                junit 'target/surefire-reports/*.xml'
              }
            }
        }

      stage('Sonarqube Analysis - SAST') {
            steps {
                  withSonarQubeEnv('SonarQube') {
           sh "sonar-scanner -X" 
                }
          //  timeout(time: 2, unit: 'MINUTES') {
          //             script {
          //               waitForQualityGate abortPipeline: true
          //           }
          //       }
              }
        }        

      stage('image bake ') {
            steps {
              sh '''
              DTE=$(date +%d-%m-%Y-%H-%M)
              docker build -t ${reg}/${serviceName}:${DTE} .
              '''
            }
        }      

      // stage('Sonarqube Analysis - SAST') {
      //       steps {
      //             withSonarQubeEnv('SonarQube') {
      //      sh "mvn sonar:sonar \
      //                         -Dsonar.projectKey=maven-jenkins-pipeline \
      //                   -Dsonar.host.url=http://34.173.74.192:9000" 
      //           }
      //      timeout(time: 2, unit: 'MINUTES') {
      //                 script {
      //                   waitForQualityGate abortPipeline: true
      //               }
      //           }
      //         }
      //   }
     }
}
