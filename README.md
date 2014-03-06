# Objective-C Resources

TODO: Write a gem description

## Installation

Install the gem:

```
$ gem install robjc
```

Run the generator:

```
$ robjc generate
```

Add `Resources/CMDResources` to your Xcode project. You might also want to add `CMDResources.h` to you prefix header.

## Usage

Watch your project for changes:

```
robjc watch
```

Use the resource classes to load data into your app:

```
// This used to be [UIImage imageNamed:@"settings-gear"]
R.image.settingsGear;

// This used to be NSLocalizedString(@"GENERAL_CANCEL", nil)
R.string.generalCancel;
```

## Contributing

1. Fork it ( http://github.com/<my-github-username>/robjc/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
