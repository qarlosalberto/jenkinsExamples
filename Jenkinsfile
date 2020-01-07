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
                            source /opt/Xilinx/Vivado/2018.2/settings64.sh
                            cd tests/fft_xilinx_modelsim
                            vivado -mode batch -source vivado_project.tcl
                            export MODELSIM_PATH=/opt/modelsim/18.0
                            export VUNIT_MODELSIM_INI=/opt/modelsim/18.0/modelsim_ase/modelsim.ini
                            export VUNIT_MODELSIM_PATH=/opt/modelsim/18.0/modelsim_ase/linuxaloem
                            cd tb
                            python3 fft_run.py
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
