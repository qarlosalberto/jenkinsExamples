pipeline {
    agent {
        docker { image 'modelsim:1.0.0'}
    }
    stages {
        stage('Run Tests') {
            parallel {
                stage('Test 0') {
                    steps {
                        echo "Test 0.."
                        sh '''
                            source /opt/Xilinx/Vivado/2018.2/settings64.sh
                            echo "Multiline shell steps works too"
                            ls -lah
                        '''
                    }
                }
                stage('Setting the variables values') {
                    steps {
                         echo "Sample..."
                    }
                }
            }
        }
    }
}
