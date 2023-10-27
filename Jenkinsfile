pipeline {
  agent {
    node {
     label 'workstation'

    }
  }

 parameters{
   choice(name: 'env', choices: ['dev','prod'], description: 'pick environment')
 }

 stages {

   stage ('TERRAFROM INIT') {
     steps {
       sh 'terraform init -backend-config=env-${env}/state.tfvars'
     }
   }

   stage ('TERRAFROM APPLY') {
        steps {
          sh 'terraform apply -auto-approve -var-file=env-${env}/main.tf'
        }
      }

 }

post {
  always {
    cleanWS()
  }
}
