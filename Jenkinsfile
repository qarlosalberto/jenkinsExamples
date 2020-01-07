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
                        sh '''#!/bin/bash
                            source --help
                            source /opt/Xilinx/Vivado/2018.2/settings64.sh
                            cd tests/fft_xilinx_modelsim
                            vivado -mode batch -source vivado_project.tcl
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
