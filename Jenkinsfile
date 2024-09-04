pipeline {
    agent any

    environment {
        // Define AWS region and S3 bucket details
        AWS_REGION = 'ap-south-1'
        S3_BUCKET_NAME = 'oriserve'
        ZIP_FILE_NAME = 'repo.zip'
    }

    stages {

        stage('Archive Repository') {
            steps {
                script {
                    echo 'Archiving repository...'
                    sh "zip -r ${ZIP_FILE_NAME} ."
                }
            }
        }

        stage('Upload to S3') {
            steps {
                script {
                    echo 'Uploading to S3...'
                    // Access AWS credentials using withCredentials block
                    withCredentials([aws(credentialsId: 'S3_Bucket', region: AWS_REGION)]) {
                        sh "aws s3 cp ${ZIP_FILE_NAME} s3://${S3_BUCKET_NAME}/${ZIP_FILE_NAME} --region ${AWS_REGION}"
                    }
                }
            }
        }

        stage('Deploy to CodeDeploy') {
            steps {
                script {
                    echo 'Deploying to CodeDeploy...'
                    // Access AWS credentials using withCredentials block
                    withCredentials([aws(credentialsId: 'S3_Bucket', region: AWS_REGION)]) {
                        sh '''
                        aws deploy create-deployment \
                            --application-name oriserve \
                            --deployment-group-name oriserve \
                            --s3-location bucket=${S3_BUCKET_NAME},key=${ZIP_FILE_NAME},bundleType=zip \
                            --region ${AWS_REGION}
                        '''
                    }
                }
            }
        }
    }
}
