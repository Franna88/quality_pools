# Quality Pools

A Flutter application for pool management, water testing, and maintenance.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## PDF Reference Documentation Setup

The app uses two reference PDF documents to generate recommendations based on pool test results. These PDFs need to be uploaded to Firebase Storage for the app to access them.

### Steps to Set Up PDF References:

1. Log in to your Firebase Console
2. Go to Storage
3. Upload the following PDF files to the root of your storage:
   - `Waterwell Pool Care Guide.pdf`: Contains information about ideal chemical levels and issues
   - `Waterwell Product Manual ~ Rev. July 2021.pdf`: Contains specific recommendations for pool water balance

### PDF Content Structure

For best results, structure your PDFs with clear sections for each chemical parameter. Each section should include:

- Chemical name (e.g., "Free Chlorine: ")
- Ideal range
- Issues when levels are too low or too high
- Recommended fixes

### Current Implementation

Currently, the app uses hardcoded example content while the PDF parsing functionality is being completed. Once the `syncfusion_flutter_pdf` library implementation is complete, the app will automatically extract content from your uploaded PDFs.

## ML Model for Test Strip Analysis

The app is designed to work with a Firebase ML model for analyzing test strip images. The model should be trained to identify:

- Chlorine levels
- pH levels
- Total alkalinity
- Calcium hardness
- Cyanuric acid levels

The current implementation uses mock data while waiting for the ML model to be fully trained and deployed.
