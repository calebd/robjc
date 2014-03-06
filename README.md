# Objective-C Resources

`robjc` turns resources in Objective-C projects into compiled constants. If an image name changes, or a localized string goes away, references to those resources in code will cause build errors.

`robjc` watches your project for changes to images and localized strings and automatically generates code that refers to those resources. All generated code is placed in `Resources/CMDResources`.

**This is experimental**. I would love to add:

- Support for loading nibs, storyboard, json files, and plists
- Better file name to method conversion
- Ability for the gem to automatically link the required files into the target project

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
