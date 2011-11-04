# Jenkins for Engine Yard

This is (as far as I know) the fastest way to get Jenkins up and running if you have an Engine Yard account. I know, you're probably thinking "wait, isn't Jenkins Java?". Yes, it is, but it doesn't matter.

So, let's get down to business:

## Usage

  1. Create a new environment on EY.
  2. Add a new application to EY, named Jenkins.
  3. Give the Jenkins application this URL: http://github.com/indirect/ey-jenkins.git
  4. Boot a single instance in your new environment.
  5. Run this on your local machine:

          git clone http://github.com/indirect/ey-jenkins.git
          cd ey-jenkins
          ey deploy

  6. Click the "HTTP" link on your EY dashboard, and that's your brand-new Jenkins installation.

## Configuration

You'll probably want create an account, enable security on Jenkins, and then create some jobs.

If you use Bundler, you'll need to undo the Bundled environment that Jenkins is running in. Go to "Manage Jenkins" and add three environment variables: `BUNDLE_BIN_PATH`, `RUBYOPT`, and `BUNDLE_GEMFILE`. Leave all three values blank.

In my projects, I also add the environment variable `CI` set to "true". That lets me do things like disable focused specs in CI runs with a line like this in my spec_helper.rb:

    config.filter_run :focused => true unless ENV["CI"]

If you use Git, you'll need to ssh into the server and run these commands as the `deploy` user:

    git config --global user.name "Jenkins"
    git config --global user.email "<your email>"

If you use private GitHub repositories, you'll also need to run `ssh-keygen -t rsa` and then add the id_rsa.pub file to your GitHub account so that Jenkins can check out your projects.

## Todo

  Add a Chef recipe so that Jenkins gets started automatically when the instance reboots. I will get around to this as soon as it really really annoys me that I have to run `ey deploy` to start Jenkins after rebooting my instances. It may take a while.