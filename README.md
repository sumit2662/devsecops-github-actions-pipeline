# 🔐 Secure CI/CD Pipeline | DevSecOps Project

A hands-on **DevSecOps project** that integrates automated secret detection, Docker image building, and vulnerability scanning into a GitHub Actions CI/CD pipeline.

The goal is to identify security issues early in the development lifecycle and prevent potentially vulnerable container images from passing the security checks.

## 🚀 Project Overview

This project demonstrates how to implement a basic security-focused CI/CD pipeline using free tools and GitHub-hosted runners.

Whenever code is pushed to the `main` branch, GitHub Actions automatically executes the configured workflow.

**Security workflow:**

```text
Developer Push
      |
      v
GitHub Actions
      |
      v
Checkout Source Code
      |
      v
Gitleaks - Secret Detection
      |
      v
Docker Image Build
      |
      v
Trivy - Vulnerability Scan
      |
      v
Pipeline Result
  PASS / FAIL
```

## 🎯 Project Objectives

- Automate security checks using GitHub Actions.
- Detect accidentally committed secrets with Gitleaks.
- Build a Docker image without installing Docker locally.
- Scan container images for HIGH and CRITICAL vulnerabilities using Trivy.
- Understand security gates and the shift-left security approach.
- Investigate failed workflows and implement appropriate fixes.
- Document security findings as part of a practical DevSecOps portfolio project.

## 🛠️ Tech Stack

| Technology | Purpose |
|---|---|
| GitHub | Source code repository |
| GitHub Actions | CI/CD automation |
| Python | Application development |
| Flask | Web application framework |
| Docker | Container image creation |
| Gitleaks | Secret detection |
| Trivy | Container vulnerability scanning |
| YAML | Workflow configuration |

## 📂 Project Structure

```text
devsecops-github-actions-pipeline/
├── .github/
│   └── workflows/
│       └── security.yml
├── app.py
├── requirements.txt
├── Dockerfile
├── .gitleaksignore
└── README.md
```

The `.gitleaksignore` file is included only if the documented fake-secret exercise requires it.

## ⚙️ How It Works

### 1. Source Code Checkout

The workflow checks out the repository so that subsequent security tools can inspect the source code and build context.

The configuration uses `fetch-depth: 0` to retrieve the full Git history for secret scanning.

### 2. Secret Detection — Gitleaks

Gitleaks scans the repository for patterns that resemble exposed credentials, API keys, and other secrets.

**Expected behavior:**
- No detected secrets: the workflow proceeds.
- A detected secret: the workflow fails, preventing later steps from running.

This demonstrates a security gate that can stop insecure changes early.

> Never commit real passwords, API keys, access tokens, or private credentials to a repository.

### 3. Docker Image Build

The pipeline builds a container image from the supplied Dockerfile.

The image uses Python 3.12 Slim, installs Flask from `requirements.txt`, copies the application source, and runs the application as a non-root user.

The image is tagged using the GitHub commit SHA to help identify the version being tested.

No local Docker installation is required because the build runs on a GitHub-hosted Ubuntu runner.

### 4. Vulnerability Scanning — Trivy

Trivy scans the locally built image for vulnerabilities classified as:

- HIGH
- CRITICAL

The workflow uses `ignore-unfixed: true`, which excludes vulnerabilities without available fixes from the scan results.

With `exit-code: '1'`, the scan is configured to fail when qualifying vulnerabilities are found.

A failed scan is a security finding that requires investigation, not automatically proof that the application has been compromised.

## 🔄 Testing the Security Pipeline

The project includes a controlled demonstration of how security checks respond to different repository states.

| Test | Expected result | Learning outcome |
|---|---|---|
| Clean repository | Pipeline passes if all checks pass | Establishes a baseline |
| Fake test secret committed | Gitleaks fails | Demonstrates secret detection |
| Test file deleted | Historical finding may remain | Shows why Git history matters |
| Known fake finding handled | Gitleaks may pass | Demonstrates controlled exception handling |
| Trivy detects qualifying vulnerabilities | Trivy fails | Demonstrates vulnerability-based blocking |

Actual results depend on the repository contents, tool behavior, and vulnerabilities detected during each run.

### Understanding the Red-to-Green Process

**Red — Secret detected:** Gitleaks identifies the deliberately introduced fake secret and blocks the workflow.

**Red — Secret remains in history:** Deleting the file does not remove the secret from previous commits. A history-aware scan may continue to detect it.

**Green — Finding handled:** After the test finding is appropriately addressed, the pipeline can proceed to the Docker build and Trivy scan.

A green result means the configured checks passed for that run. It does not guarantee that the application is completely secure.

## 🔒 Security Considerations

- Use fake credentials exclusively for demonstrations.
- Rotate and revoke real exposed credentials immediately.
- Deleting a file does not erase sensitive information from Git history.
- Do not use `.gitleaksignore` to hide genuine credential leaks.
- Verify the fingerprint and finding details before ignoring a known test finding.
- Review HIGH and CRITICAL Trivy findings and update vulnerable dependencies or base images where appropriate.
- Pin third-party GitHub Actions to verified commit SHAs in production workflows.
- Keep GitHub Actions permissions restricted to the minimum required.
- Do not deploy the image to production without additional testing and approval.

**Important:** The ignore entry used in this exercise is intended only for the known fake test finding. It is not a remediation strategy for real secrets.

## 📸 Project Evidence

Add your actual GitHub Actions screenshots to this section to demonstrate the pipeline's behavior.

Suggested screenshots:

1. `3-pipeline-red-gitleaks.png` — Gitleaks blocks the workflow.
2. `4-gitleaks-finding-details.png` — Details of the detected fake test secret.
3. `5-gitleaks-summary.png` — Gitleaks findings summary.
4. `6-still-red-after-delete.png` — Historical detection after deleting the test file.
5. `7-green-after-fix.png` — Successful run after addressing the test finding.

You can upload the screenshots to a folder named `screenshots/` and reference them like this:

```markdown
![Gitleaks finding details](screenshots/4-gitleaks-finding-details.png)

![Pipeline after the fix](screenshots/7-green-after-fix.png)
```

Only include screenshots that you have actually captured. Replace filenames if your uploaded evidence uses different names.

## ▶️ Run the Project

### Prerequisites

- A GitHub account
- A repository with GitHub Actions enabled

Docker is not required on your local machine for the automated pipeline.

### Steps

1. Create the repository and add the application files.
2. Add `.github/workflows/security.yml`.
3. Commit and push the files to the `main` branch.
4. Open the **Actions** tab on GitHub.
5. Select **DevSecOps Pipeline**.
6. Open the latest run and inspect each step.
7. Investigate any failures before considering the pipeline successful.

The workflow also supports manual execution through `workflow_dispatch`.

## 📚 Key Learnings

Through this project, I am learning how to:

- Implement CI/CD automation with GitHub Actions.
- Integrate secret scanning into a development workflow.
- Build Docker images in a cloud-hosted runner.
- Detect container vulnerabilities using Trivy.
- Understand Git history and secret exposure.
- Configure security gates that fail builds when configured conditions are met.
- Troubleshoot pipeline failures and document security evidence.
- Apply the shift-left security principle in DevSecOps.

## 🔮 Future Improvements

Planned enhancements include:

- Add Python dependency vulnerability scanning.
- Integrate Python linting and automated unit tests.
- Add static application security testing (SAST).
- Generate and publish machine-readable security reports.
- Add software bill of materials (SBOM) generation.
- Scan infrastructure-as-code configurations.
- Add container image signing and provenance verification.
- Introduce a controlled deployment stage after security checks pass.

## 👨‍💻 Author

**Sumit Jadhav**

Cyber Security Student | Aspiring DevSecOps Engineer

GitHub: (https://github.com/sumit2662)
YouTube: www.youtube.com/@officialhackwithsumit
LinkedIn: https://www.linkedin.com/in/sumit-jadhav-67090b2a6

## ⚠️ Disclaimer

This repository is intended for educational and portfolio purposes. The pipeline demonstrates selected automated security checks and does not replace a comprehensive security assessment, secure software development lifecycle, or production deployment review.

---

**Built to learn. Tested to improve. Secured by design.** 🔐
