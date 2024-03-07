pipeline {
    agent any
    tools {
        maven 'maven3.8' // 引用你在全局配置中设置的Maven名称
    }

    environment {
        // 设置环境变量，如Maven和Docker相关配置
        MAVEN_OPTS = "-Dmaven.repo.local=/wj/jenkins/maven/apache-maven-3.8.8/repo"
        IMAGE_NAME = 'chinapopin.com:18443/k8s/order'
        TAG = 'latest'
        REGISTRY_URL = 'https://chinapopin.com:18443/'
        DOCKER_CREDENTIAL_ID = '234harbor' // Harbor的凭证ID
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scmGit(branches: [[name: "${branch}"]], extensions: [], userRemoteConfigs: [[credentialsId: 'hubor-cre', url: 'https://github.com/1056661516/order.git']])
                //git credentialsId: 'hubor-cre', url: 'https://github.com/1056661516/hellowworld.git'
            }
        }
        stage('Build JAR') {
            steps {
                sh 'mvn clean package'
            }
        }
        
        
    stage('Build Docker Image') {
        steps {
            dir("${workspace}/xxl-job-admin"){  //切换到执行build的目录
                script {
                    docker.withRegistry("${REGISTRY_URL}", '234harbor') {
                    def customImage = docker.build("${IMAGE_NAME}:${TAG}")

                        // 使用credentialsId指向Harbor凭证
                    customImage.push()
                    //dockerImage = docker.build("${IMAGE_NAME}:${TAG}")
                    sh 'docker rmi "${IMAGE_NAME}:${TAG}"'
                    }
                }    
            }

        }
    }
    
    stage('Execute K8s Command') {
        steps {
            sh 'kubectl get nodes'
        }
    }    
    
 
    }
}
