node{
  stage ("Hello") {
      echo "hello"
  }
  stage ("Get env") {
      echo sh(script: 'env|sort', returnStdout: true)
  }
}
