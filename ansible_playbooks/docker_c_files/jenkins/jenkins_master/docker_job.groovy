job('hello_world') {
    scm {
        git {
            remote {
                url('https://github.com/throw-rt/udemx_hw_support.git')
                credentials('Jenkins_udemx')
            }
            branches('main')
        }
    }

    steps {
        shell('docker build -t hello_world_jenkins .')
        shell('docker tag hello_world_jenkins:latest localhost:9000/hello_world_jenkins:latest')
        shell('docker push localhost:9000/hello_world_jenkins:latest')
        shell('docker stop hello_world_jenkins || true')
        shell('docker run -dp 9005:80 --name hello_world_jenkins --rm localhost:9000/hello_world_jenkins:latest ')
    }


}


