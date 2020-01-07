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
                            #!/bin/bash
                            source /opt/Xilinx/Vivado/2018.2/settings64.sh
                            vivado -help
                            cd tests/fft_xilinx_modelsim/
                            vivado -mode batch -source vivado_project.tcl
                            cd tb
                            python3 fft_run.py
                        '''
                    }
                }
                stage('Setting the variables values') {
                    steps {
                         sh "vivado -help"
                    }
                }
            }
        }
    }
}
