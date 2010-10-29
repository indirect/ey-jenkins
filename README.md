# Hudson for Engine Yard

This is (as far as I know) the fastest way to get Hudson up and running if you have an Engine Yard account. I know, you're probably thinking "wait, isn't Hudson Java?". Yes, it is, but it doesn't matter.

So, let's get down to business:

## Usage

  1. Create a new environment on EY.
  2. Add a new application to EY, named Hudson.
  3. Give the Hudson application this URL: http://github.com/indirect/ey-hudson.git
  4. Boot a single instance in your new environment.
  5. Run this on your local machine:

          git clone http://github.com/indirect/ey-hudson.git
          cd ey-hudson
          ey deploy

  6. Click the "HTTP" link on your EY dashboard, and that's your brand-new Hudson installation.

## Todo

  Add a Chef recipe so that Hudson gets started automatically when the instance reboots. I will get around to this as soon as it really really annoys me that I have to run `ey deploy` to start Hudson after rebooting my instances. It may take a while.