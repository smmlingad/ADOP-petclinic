pipeline{
    agent any
    stages{
        stage('Git-Checkout'){
            steps{
                echo "Checking out from Git Repo";
                git 'https://github.com/DianneManimtim/ADOP-petclinic.git'
            }
        }
        
        stage('Build'){
            steps{
                echo "Building out the checked-out project";
                sh label: '', script: 'mvn clean install package'
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
                echo "Pushing image to dockerhub account";
                sshPublisher(publishers: [sshPublisherDesc(configName: 'ansible_server', transfers: [sshTransfer(cleanRemote: false, excludes: '', execCommand: '''cd /opt/docker;
cat my_pass.txt | docker login -u diannemanimtim --password-stdin;
docker build -t hello_world_demo .;
docker tag hello_world_demo diannemanimtim/hello_world_demo;
docker push diannemanimtim/hello_world_demo;
docker rmi hello_world_demo diannemanimtim/hello_world_demo;''', execTimeout: 120000, flatten: false, makeEmptyDirs: false, noDefaultExcludes: false, patternSeparator: '[, ]+', remoteDirectory: '//opt//docker', remoteDirectorySDF: false, removePrefix: '', sourceFiles: 'Dockerfile')], usePromotionTimestamp: false, useWorkspaceInPromotion: false, verbose: false)])
            }
        }
        
        stage('Pull image'){
            steps{
                echo "Pulling image from docker hub";
                sshPublisher(publishers: [sshPublisherDesc(configName: 'ansible_server', transfers: [sshTransfer(cleanRemote: false, excludes: '', execCommand: '''cd /opt/playbooks;
ansible-playbook dp.yml;''', execTimeout: 120000, flatten: false, makeEmptyDirs: false, noDefaultExcludes: false, patternSeparator: '[, ]+', remoteDirectory: '', remoteDirectorySDF: false, removePrefix: '', sourceFiles: '')], usePromotionTimestamp: false, useWorkspaceInPromotion: false, verbose: false)])
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
