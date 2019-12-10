pipeline {
    agent {
        docker { image 'vivado:2019.2' }
    }
    stages {
        stage('Run Tests') {
            parallel {
                stage('Test 0') {
                    steps {
                        echo "Test 0.."                        
                        sh '''
                            #!/bin/bash
                            vivado -help
                        '''
                    }
                }
                stage('Setting the variables values') {
                    steps {
                         echo "Test 1.."
                    }
                }
            }
        }
    }
}
