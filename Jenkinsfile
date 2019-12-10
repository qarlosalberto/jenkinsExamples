pipeline {
    agent {
        docker { image 'vivado:2019.2' }
    }
    stages {
        stage('Run Tests') {
            parallel {
                stage('Test 0') {
                    steps {
                        echo "hi"
                    }
                }
                stage('Test 1') {
                    steps {
                        echo "Test 1..."
                    }
                }
            }
        }
    }
}
