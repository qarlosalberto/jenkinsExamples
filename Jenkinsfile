pipeline {
    agent {
        docker { image 'vivado:2019.2' }
    }
    stages {
        stage('Run Tests') {
            parallel {
                stage('Test 0') {
                    steps {
                        bash "source /opt/Xilinx/Vivado/2019.2/settings64.sh"
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
