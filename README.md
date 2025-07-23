# mon_test
A project of IAC, Python, Docker and CI CD concepts


- How to run the project locally and using Docker;

        python3.13 -m venv env

        source env/bin/actvate

        pip install -r requirements.txt

        uvicorn app.main:app --host 0.0.0.0 --port 8000


Once running your application locally you can run on a container

        docker build -t fastapi-app:version1.0 .

        docker run fastapi-app:version1.0

        docker run -d fastapi-app:version1.0

If does't access form 0.0.0.0:8000

        docker network ls

        docKer network inspect bridge

Usually the address will be 172.17.0.2 or something like that, for locally;

        curl --verbose 172.17.0.2:8000/health

        172.17.0.2:8000/
        
After all tests locally we will use github repositories and actions workflows to CI/CD

        git add . 

        git commit -m "First versions of the python app"

        git push

In the terraform folder run:

        terraform init

        terraform plan

        terraform fmt

        teraform apply

To run the Github Action:

        gh workflow run CD_CD_deploinebt_dev


- What was the major issue that you had and how id you solve it?
    Because the short time, I just delivered the dev environment, but I  need work with new stages in dev and for the QA and Prod, so to solv it I would need more time;


- How do you envision all the environments?
    1. Local Development
    2. Development / Dev Environment
    3. QA Environment
    4. Production Environment


- How do you envision the workflow of the project?

Planning:

    1- Planning

        - Define goals, scope, and success metrics

        - Create a roadmap or milestones

        - Use GitHub Projects or tools like Jira/Trello to track tasks

        - Draft issues for features, bugs, and enhancements

    2. Development Workflow
    
    Branching Strategy: Use Git (e.g., main, dev, feature/*, bugfix/*)

    Issue → Branch → Pull Request:

        - Link branches to issues

        - Open draft PRs early for visibility

    Code Reviews:

        - Assign reviewers

        - Use GitHub’s review tools and comments

    Testing:

        - Automated via CI/CD (e.g., GitHub Actions, Jenkins)

    3. Deployment & Delivery
    
        - Use CI/CD pipelines to build, test, and deploy

        - Staging environments for QA

        - Production releases with tagging (v1.0.0)

        - Monitor performance and errors (e.g., Sentry, Datadog)

    4. Feedback & Iteration

        - Prioritize improvements and bug fixes

        - Repeat the cycle with updated goals and backlog grooming

    5. Collaboration & Communication
    
        - Use GitHub Discussions or Slack/Teams for async updates

        - Weekly standups or sprint reviews

        - Document decisions in the repo (e.g., /docs, /decisions)


- What alternative do you propose for env variable management?
    Work with Github env secreets or through Amazon ECS environment variables

- How would you improve availability in a production environment?
    It needed create the workflow to QA and Prod environment;

- If you ran out of time, how did you envision your finished project?
    If needed work extra time to finish and deliver;

- What is your recommendation for future work?
    It need doing another workflows and steps to scan the image vulnerabilty before go to QA and Prod ambients.