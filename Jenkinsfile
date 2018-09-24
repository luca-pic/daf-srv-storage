pipeline {
    agent any

    stages {
        stage('Compile') {
            steps {
                slackSend (message: "BUILD START: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]' CHECK THE RESULT ON: https://cd.daf.teamdigitale.it/blue/organizations/jenkinss/daf-srv-storage/activity")
                // sh 'sbt clean compile'
            }
        }
        stage('Publish') {
            steps {
                // sh 'sbt docker:publish'
            }
        }
        stage('Deploy test'){
            when {
                branch 'test'
            }
            environment {
                DEPLOY_ENV = 'test'
                KUBECONFIG = '${JENKINS_HOME}/.kube/config.teamdigitale-staging'
            }
            steps {
                sh '''export KUBECONFIG="${KUBECONFIG}"; cd kubernetes; sh deploy.sh test'''
                slackSend (color: '#00FF00', message: "SUCCESSFUL: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}] deployed in '${env.DEPLOY_ENV}' https://cd.daf.teamdigitale.it/blue/organizations/jenkins/daf-srv-storage/activity")
            }
        }
        stage('Deploy production') {
            when {
                branch 'master'
            }
            environment {
                DEPLOY_ENV = 'prod'
                KUBECONFIG = '${JENKINS_HOME}/.kube/config.teamdigitale-prod'
            }
            steps {
                sh 'cd kubernetes; sh deploy.sh'
                slackSend (color: '#00FF00', message: "SUCCESSFUL: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}] deployed in '${env.DEPLOY_ENV}' https://cd.daf.teamdigitale.it/blue/organizations/jenkins/daf-srv-storage/activity")
            }
        }
    }
    post {
        failure {
            slackSend (color: '#ff0000', message: "FAIL: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]' https://cd.daf.teamdigitale.it/blue/organizations/jenkins/daf-srv-storage/activity")
        }
    }
}
