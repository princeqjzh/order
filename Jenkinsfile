pipeline {
  agent any
  stages {
    stage("检出") {
      steps {
        checkout([
          $class: 'GitSCM',
          branches: [[name: env.GIT_BUILD_REF]],
          userRemoteConfigs: [[
            url: env.GIT_REPO_URL,
            credentialsId: env.CREDENTIALS_ID
        ]]])
      }
    }
    stage('自定义构建过程') {
      steps {
        echo "自定义构建过程开始"
        // 请在此处补充您的构建过程
        sh 'ls -l'
        sh'echo hello coding>test.txt'
        sh 'ls -l'
      }
    }
  }
}
