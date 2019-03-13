pipeline{
    agent any
    stages{
       stage('Git-Checkout'){
            steps{
                echo "Checking out from Git Repo";
                git 'https://github.com/smmlingad/ADOP-petclinic'
            }
        }
        
       stage('Build'){

            steps{
                echo "Building out the checked-out project";
                sh 'mvn -B -DskipTests clean install package'
            }
        }

       stage("Unit Tests"){

            steps{
                echo 'This job runs unit tests on Java Spring reference application.'
                sh "mvn test"
            } 
        }
        
        stage('SSH-Copy'){
            steps{
                echo "Copying war file from Jenkins";
                sshPublisher(publishers: [sshPublisherDesc(configName: 'ansible_server', transfers: [sshTransfer(cleanRemote: false, excludes: '', execCommand: '', execTimeout: 120000, flatten: false, makeEmptyDirs: false, noDefaultExcludes: false, patternSeparator: '[, ]+', remoteDirectory: '//opt//docker', remoteDirectorySDF: false, removePrefix: 'webapp/target', sourceFiles: 'webapp/target/*.war')], usePromotionTimestamp: false, useWorkspaceInPromotion: false, verbose: false)])
            }
        }
        
        stage('Push image'){
            steps{
                sshPublisher(publishers: [sshPublisherDesc(configName: 'ansible_server', transfers: [sshTransfer(cleanRemote: false, excludes: '', execCommand: '''cd /opt/docker;
                cat pass.txt | docker login -u smmlingad --password-stdin;
                docker build -t hello_world_demo .;
                docker tag hello_world_demo smmlingad/hello_world_demo;
                docker push smmlingad/hello_world_demo;
                docker rmi hello_world_demo smmlingad/hello_world_demo;''', execTimeout: 120000, flatten: false, makeEmptyDirs: false, noDefaultExcludes: false, patternSeparator: '[, ]+', remoteDirectory: '//opt//docker', remoteDirectorySDF: false, removePrefix: '', sourceFiles: 'Dockerfile')], usePromotionTimestamp: false, useWorkspaceInPromotion: false, verbose: false)])
            }
        }
        
        stage('Pull image'){
            steps{
                sshPublisher(publishers: [sshPublisherDesc(configName: 'ansible_server', transfers: [sshTransfer(cleanRemote: false, excludes: '', execCommand: '''cd /opt/playbooks;
                ansible-playbook task3.yml;''', execTimeout: 120000, flatten: false, makeEmptyDirs: false, noDefaultExcludes: false, patternSeparator: '[, ]+', remoteDirectory: '', remoteDirectorySDF: false, removePrefix: '', sourceFiles: '')], usePromotionTimestamp: false, useWorkspaceInPromotion: false, verbose: false)])
            }
        }
        
    }
    
    post{
        always{
            echo "This will always run"
        }
        success{
            echo "This will run only if successful"
        }
        failure{
            echo "This will run only if failure"
        }
        unstable{
            echo "This will run only if unstable"
        }
        changed{
            echo "This will run only if the state of the pipeline has changed"
            echo "For example, if the pipeline was previously failing but is now successful"
        }
    }
}
