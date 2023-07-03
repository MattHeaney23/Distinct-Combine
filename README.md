# Distinct-Combine

Using Combine, create a custom publisher, subscriber, and subscription to implement new behaviour. This new publisher will only be able to emit unique values.

To gain experience using Combine, I asked ChatGPT to generate challenges to complete. This repo is my solution.

## The Challenge

- Implement the DistinctPublisher by conforming to the Publisher protocol. Emit a sequence of values from an array, filtering out duplicates to ensure only distinct values are emitted.
- Implement the DistinctSubscription by conforming to the Subscription protocol. Manage the demand from the subscriber and emit values accordingly.
- Implement the DistinctSubscriber by conforming to the Subscriber protocol.
- Test your implementation by creating an instance of the DistinctPublisher, subscribing it to the DistinctSubscriber, and observing the emitted values. Verify that only distinct values are printed or stored, with duplicates filtered out.
- Ensure your solution handles various scenarios, such as empty input, single values, and arrays with duplicate and distinct values. Write unit tests to validate the functionality of your custom publisher, subscription, and subscriber.

## About the Solution

- I created a new publisher object, called DistinctPublisher. This is generic, allowing it to work with any hashable type. This is initiated with an array of values to emit. When this receives a new subscriber, it creates a new DistinctSubscription object, providing this to the subscriber received.
- I created a new subscription, called DistinctSubscription. This manually handles the demand for values, ensuring that too many values are not emitted. This also manually filters the values to deliver to the subscriber, ensuring only unique values are emitted.
- I created a new subscriber, called DistinctSubscriber. This requests one value at a time. This required closures for onReceived and onCompletion to mirror the logic of 'sink'.
- I created a range of unit tests to assert the logic. These tests cleanly test outputs for an array of integers, an array of strings, an array with a single string, an array with a lot of strings, and an empty array.

## Note

- This could have been handled with a custom operator in an extension on Publisher. However, I used this challenge to further my understanding of manually creating publishers, subscribers, and subscriptions, and how they all link together. I also developed a deeper understanding of back-pressure strategies by creating the custom subscription.

## Screenshots

- There are no screenshots for this project, as the logic is tested via unit tests.
