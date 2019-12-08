pipeline {
    agent {
        docker { image 'terostech/multi-simulator:1.0.0' }
    }
    stages {
        stage('Run Tests') {
            parallel {
                stage('Test 0') {
                    steps {
                        echo "Test 0..."
                    }
                }
                stage('Test 1') {
                    steps {
                        sh "Test 1..."
                    }
                }
            }
        }
    }
}
