pipeline {
    agent { node { label 'worker-1' } }

    stages {
        stage('Checkout') {
            steps {
                script {
                    // Clone the private GitHub repository using credentials
                    checkout([$class: 'GitSCM', branches: [[name: 'main']], userRemoteConfigs: [[
                        url: 'https://github.com/RehanyTamas/udemx_hazi_jenkins.git',
                        credentialsId: 'Jenkins_udemx'
                    ]]])
                }
            }
        }
        
        stage('Build Docker Image') {
            steps {
                sh "docker build -t hello_world ."
            }

        }
        
        stage('Push into registry') {
            steps {
                sh "docker tag hello_world:latest localhost:80/hello_world:latest"
                sh "docker push localhost:80/hello_world:latest"
            }

        }
    }
}
