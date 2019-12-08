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
                test0: {
                    echo 'Testing 0..'
                },
                test1: {
                    echo 'Testing 0..'
                },
                test2: {
                    echo 'Testing 0..'
                }
            }
        }
        stage('Deploy') {
            steps {
                echo 'Deploying....'
            }
        }
    }
}
