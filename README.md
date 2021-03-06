# Alexa Log Weight
This is a side project to log my weight to Fitbit using Alexa.

## Setting up your Lambda Function
1. Log into the [AWS management Console](https://aws.amazon.com/). Create an account if you need to.
2. From the list of services, select Lambda
3. Set your region to **US East (N. Virginia)**
4. Choose Create a Lambda Function
5. In the search filter box, type Alexa
6. Select blueprint **alexa-skills-kit-color-expert-python**
7. Name your function. I call mine logWeight
8. Under Lambda function handler and role, select **Create a custom role**.
9. When the IAM role management console opens, choose **Allow** to go back to the previous Lambda console.
10. The role should read `lambda_basic_execution`.
11. In your [IAM roles](https://console.aws.amazon.com/iam/home#/roles) attach the **AWSLambdaFullAccess** policy to your role.
12. Add environment variables. These give you access to Fitbit. Note that the Alexa application id and the Alexa test application id are filtered.
    1. **CLIENT_SECRET**
    2. **CLIENT_ID**
    3. **EXPIRES_AT**
    4. **REDIRECT_URI**
    5. **REFRESH_TOKEN**
    6. **TOKEN**
    7. **ALEXA_APPLICATION_ID**
    8. **ALEXA_TEST_APPLICATION_ID**

## Setting up your Amazon developer portal
1. Sign into the [Amazon Developer Portal](https://developer.amazon.com/login.html).
2. Select Alexa
3. Under **Alexa Skills Kit**, choose **Get Started**
4. Choose **Add a New Skill**
5. Name your skill. It doesn’t really matter what it is.
6. Create an invocation name. I gave it a name of my assistant `Alan` so that I can say “Alexa, tell Alan my weight is 165 pounds”.  Note that there are [limits](https://developer.amazon.com/docs/custom-skills/choose-the-invocation-name-for-a-custom-skill.html) to how you can invoke this skill. For example, you cannot (unfortunately) say “Alexa, I weigh 165 pounds”.
7. Choose Next
8. In the Intent Schema box, paste the following JSON code
```JSON
{
  "intents": [
    {
      "slots": [
        {
          "name": "Weight",
          "type": "AMAZON.NUMBER"
        },
        {
          "name": "PartialWeight",
          "type": "AMAZON.NUMBER"
        }
      ],
      "intent": "MyWeightIsIntent"
    },
    {
      "intent": "WhatsMyWeightIntent"
    },
    {
      "intent": "AMAZON.HelpIntent"
    }
  ]
}
```
10. Under the Sample Utterances enter
```
MyWeightIsIntent my weight is {Weight} pounds
MyWeightIsIntent my weight is {Weight} dot {PartialWeight} pounds
MyWeightIsIntent my weight is {Weight} point {PartialWeight} pounds
MyWeightIsIntent my weight is {Weight}
MyWeightIsIntent my weight is {Weight} point {PartialWeight}
MyWeightIsIntent I weigh {Weight}
MyWeightIsIntent I weigh {Weight} point {PartialWeight}
MyWeightIsIntent I weigh {Weight} pounds
MyWeightIsIntent I weigh {Weight} point {PartialWeight} pounds
MyWeightIsIntent {Weight} is my weight
MyWeightIsIntent {Weight} point {PartialWeight} is my weight
MyWeightIsIntent {Weight} pounds is my weight
MyWeightIsIntent {Weight} point {PartialWeight} pounds is my weight
MyWeightIsIntent Today my weight is {Weight}
MyWeightIsIntent Today my weight is {Weight} point {PartialWeight}
MyWeightIsIntent Today my weight is {Weight} pounds
MyWeightIsIntent Today my weight is {Weight} pounds
MyWeightIsIntent I am {Weight}
MyWeightIsIntent I am {Weight} point {PartialWeight}
MyWeightIsIntent I am {Weight} pounds
MyWeightIsIntent I am {Weight} point {PartialWeight} pounds
WhatsMyWeightIntent what's my weight
WhatsMyWeightIntent what is my weight
WhatsMyWeightIntent what's my weight
WhatsMyWeightIntent what is my weight
WhatsMyWeightIntent my weight
WhatsMyWeightIntent get my weight
WhatsMyWeightIntent give me my weight
WhatsMyWeightIntent what my weight is
WhatsMyWeightIntent yes
WhatsMyWeightIntent yup
WhatsMyWeightIntent sure
WhatsMyWeightIntent yes please
```
12. Choose Next
13. Select the Endpoint **AWS Lambda ARN** then paste your ARN code from step 1-14. Select **North America** as your region, and for **Account Linking** select **No**, then choose **Next**.

## Uploading the code
1. AWS Lambda requires all python packages to be at the root file level.
2. While within the project directory you can call `./install.sh` to install all of the requirements.
3. Zip up all of the files by running `zip -r -X lambdaD.zip .`
4. Then upload the zipfile to your lambda function

## Resources and Credit
- https://developer.amazon.com/alexa-skills-kit/alexa-skill-quick-start-tutorial
- https://github.com/orcasgit/python-fitbit