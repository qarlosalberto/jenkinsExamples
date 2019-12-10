pipeline {
    agent {
        docker { image 'vivado:2019.2' }
    }
    stages {
        stage('Run Tests') {
            parallel {
                stage('Test 0') {
                    steps {
                        sh '''#!/bin/bash
                            source /opt/Xilinx/Vivado/2019.2/settings64.sh
                            vivado -help
                        '''
    
                    }
                }
                stage('Setting the variables values') {
                    steps {
                         sh '''#!/bin/bash
                                 echo "hello world" 
                         '''
                    }
                }
            }
        }
    }
}
