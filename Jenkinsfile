pipeline {
    agent any

    stages {
        stage('Compile') {
            steps {
            if(env.BRANCH_NAME=='master'){
            agent { label 'prod' }
            
                slackSend (message: "BUILD START: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]' CHECK THE RESULT ON: https://cd.daf.teamdigitale.it/blue/organizations/jenkinss/daf-srv-storage/activity")
                sh 'sbt clean compile'
            }
            else{
                slackSend (message: "BUILD START: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]' CHECK THE RESULT ON: https://cd.daf.teamdigitale.it/blue/organizations/jenkinss/daf-srv-storage/activity")
                sh 'sbt clean compile'
            }
            }
        }
        stage('Publish') {
            steps {
            if(env.BRANCH_NAME=='master'){
            agent { label 'prod' }
            
                // echo 'sbt docker:publish'
                sh 'sbt docker:publish'
            }
            else{
                // echo 'sbt docker:publish'
                sh 'sbt docker:publish'
            }
        }
        }
        stage('Deploy test'){
            when {branch 'test'}
            environment {
                DEPLOY_ENV = 'test'
                KUBECONFIG = '/var/lib/jenkins/.kube/config.teamdigitale-staging'
            }
            steps {
                sh 'cd kubernetes; sh deploy.sh'
                slackSend (color: '#00FF00', message: "SUCCESSFUL: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}] deployed in '${env.DEPLOY_ENV}' https://cd.daf.teamdigitale.it/blue/organizations/jenkins/daf-srv-storage/activity")
            }
        }
        stage('Deploy production') {
            when {
                branch 'master'
            }
            agent { label 'prod' }
            environment {
                DEPLOY_ENV = 'prod'
                KUBECONFIG = '/home/centos/.kube/config.teamdigitale-production'
            }
            steps {
                sh 'whoami' 
                sh 'pwd'
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

