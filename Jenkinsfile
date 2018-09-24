pipeline{
    agent any

     stages {
        stage('Build') {
         steps {
             script{
             if(env.BRANCH_NAME=='testci'){
                slackSend (message: "BUILD START: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]' CHECK THE RESULT ON: https://cd.daf.teamdigitale.it/blue/organizations/jenkins/CI-Storage_Manager/activity")
                sh '''
                sbt ';clean; compile; docker:publish'
                '''
                }
             }
            }
         }
        stage('Staging'){
            steps{
            script{
                if(env.BRANCH_NAME=='testci'){
                    // kubectl delete -f  daf-storage-manager-test.yml
                    sh '''
                    cd kubernetes
                    sh config-map-test.sh
                    kubectl --kubeconfig=${JENKINS_HOME}/.kube/config.teamdigitale-staging replace -f  daf-storage-manager-test.yml --force
                    '''
                    slackSend (color: '#00FF00', message: "SUCCESSFUL: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]' https://cd.daf.teamdigitale.it/blue/organizations/jenkins/CI-Storage_Manager/activity")
            }
            }
        }
     }
     }
     post {
        failure {
            slackSend (color: '#ff0000', message: "FAIL: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]' https://cd.daf.teamdigitale.it/blue/organizations/jenkins/CI-Storage_Manager/activity")
        }
    }
}
