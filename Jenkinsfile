pipeline {
    agent any

    environment {
        STUDENT_NAME    = 'Zhansaya'
        STUDENT_SURNAME = 'Kalymova'
        STUDENT_GROUP   = 'IT2-2312'
        STUDENT_ID      = '37552'
        IMAGE_NAME      = 'kalymova-zhansaya-devops'
        CONTAINER_NAME  = 'kalymova-zhansaya-container'
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
                sh 'git log -1 --pretty=format:"Commit used by Jenkins: %h %s (%an)"'
            }
        }

        stage('Build') {
            steps {
                echo "Student: ${env.STUDENT_NAME} ${env.STUDENT_SURNAME}"
                echo "Group: ${env.STUDENT_GROUP}"
                echo "Student ID: ${env.STUDENT_ID}"
                sh 'chmod +x scripts/Kalymova_Zhansaya_system.sh'
                sh './scripts/Kalymova_Zhansaya_system.sh'
            }
        }

        stage('Test') {
            steps {
                sh 'test -f Dockerfile && echo "Dockerfile found"'
                sh 'test -f app/app.py && echo "app.py found"'
                sh 'grep -q "Kalymova" Kalymova_Zhansaya_info.txt && echo "Student info file is correct"'
                sh 'bash -n scripts/Kalymova_Zhansaya_system.sh && echo "Bash script syntax OK"'
            }
        }

        stage('Docker Build') {
            steps {
                sh 'docker build -t $IMAGE_NAME:$BUILD_NUMBER -t $IMAGE_NAME:latest .'
                sh 'docker images $IMAGE_NAME'
            }
        }

        stage('Docker Run') {
            steps {
                sh 'docker rm -f $CONTAINER_NAME || true'
                sh '''
                    docker run -d -p 8000:8000 \
                      -e STUDENT_NAME="$STUDENT_NAME" \
                      -e STUDENT_SURNAME="$STUDENT_SURNAME" \
                      -e STUDENT_GROUP="$STUDENT_GROUP" \
                      -e STUDENT_ID="$STUDENT_ID" \
                      --name $CONTAINER_NAME $IMAGE_NAME:latest
                '''
                sh 'sleep 3 && docker logs $CONTAINER_NAME'
                sh 'docker ps -a --filter name=$CONTAINER_NAME'
            }
        }
    }

    post {
        success { echo 'Pipeline finished successfully!' }
        failure { echo 'Pipeline failed - look at the red stage.' }
    }
}
