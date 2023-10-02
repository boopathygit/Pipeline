pipeline {

    Parameters {
        booleanParam(name: 'autoapprove', defaultValue: false, description: 'Automatically run apply after generating plan?')
    }
    environment {
        AWS_ACCESS_KEY_ID      = credentials('AWS_ACCESS_KEY_ID')
        AWS_SECRET_ACCESS_KEY  = credentials('AWS_SECRET_ACCESS_KEY')
    }
   
   agent any
    stages {
       stage('checkout') {
          steps {
               script{
                     dir("terraform")
                     {
                       git "https://github.com/boopathygit/TerraJenk.git "
                     }
               } 
          }
       }     
       
       stage('Plan') {
          steps {
              sh 'pwd;cd terraform/ ; terraform init'
              sh 'pwd;cd terraform/ ; terraform plan -out tfplan'
              sh 'pwd;cd terraform/ ; terraform show -no-color tfplan > tfplan.txt'
          }
       } 
       stage('Approval') {
          when {
             not {
                 equals expected: true, actual: params.autoApprove
             }
          }
       }
       
       steps {
          script {
              def plan = readFile 'terraform/tfplan.txt'
              input message: "Do you want to apply the plan?",
              Parameters: [text(name: 'Plan', description: 'Please review the plan', defaultVaule: plan)]
          }
       }  
    }

    stage('Apply') {
       steps {
          sh "pws;cd terraform/ ; terraform apply -input=false tfplan"
       }
    }
  }

}  
