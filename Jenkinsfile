pipeline {
    agent {
        docker { image 'terostech/multi-simulator:1.0.0' }
    }
    stages {
        stage('Build') {
            steps {
                echo 'Building..'
            }
        }
        stage('Test') {
            steps {
                echo 'Testing 0..'
            }
            steps {
                echo 'Testing 1..'
            }
            steps {
                echo 'Testing 2..'
            }
        }
        stage('Deploy') {
            steps {
                echo 'Deploying....'
            }
        }
    }
}
