help=" Lorem ipsilum generator.
 Usage: $0 [-s] [-m] [-l]
 
 Options:
   -h        Display this help message
   -s        generate short lorem
   -m        generate medium lorem
   -l        generate long lorem"

long_lorem="Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis libero neque, semper ut arcu eget, porta condimentum libero. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Fusce blandit lacinia nunc vel tempus. Cras a risus et tellus blandit vestibulum non at libero. Morbi molestie condimentum convallis. Integer pharetra venenatis nisi, eget tincidunt dolor molestie non. Sed vitae ultricies diam. Duis consectetur sem sed purus vestibulum, et gravida tellus mattis. Duis cursus enim vestibulum, venenatis tellus ut, venenatis nisl. Aenean pretium, ligula at tempus aliquam, sapien orci malesuada mauris, nec tempor augue enim id odio. Vestibulum malesuada odio quis luctus tincidunt. Suspendisse at lorem ullamcorper, suscipit augue quis, viverra leo. Nunc eget lacus ipsum.

Cras ac porttitor velit, id tempus nunc. In gravida, sapien at rhoncus vehicula, ligula nibh sagittis justo, id porta neque sapien id est. Suspendisse molestie erat sed lectus ultrices, at condimentum nibh malesuada. Suspendisse massa tortor, pharetra vitae pellentesque a, laoreet ut ante. Phasellus eu enim ac turpis porttitor sodales. Vivamus urna nibh, hendrerit a mattis sit amet, luctus in orci. Praesent ligula quam, placerat ac lorem eget, eleifend tristique erat. Cras sit amet tellus quam. Pellentesque viverra eu mi quis gravida. Duis ante leo, auctor a leo et, pellentesque efficitur tellus. Nulla facilisi. Nam semper enim nec ante tristique, quis dignissim mauris tempor. Nam nunc tellus, molestie id eros vel, blandit tempus felis. Fusce ultrices blandit metus, ut mollis sem consectetur vitae. Pellentesque vel tempus massa.

Vestibulum dui ex, malesuada sit amet hendrerit eget, venenatis vitae nulla. Praesent vitae congue magna, vel laoreet tortor. Vestibulum volutpat eleifend efficitur. Ut a urna aliquam, rhoncus neque eget, blandit arcu. Aenean tincidunt quam mauris, at gravida tellus imperdiet nec. Integer congue orci mattis mauris venenatis vestibulum. Nullam volutpat hendrerit urna, eget feugiat orci cursus sit amet. Vivamus at efficitur eros. Phasellus pulvinar nibh non efficitur blandit. Nunc ac justo malesuada sapien feugiat ultrices sit amet in ante. Mauris tincidunt urna in cursus vestibulum. Nunc eu gravida est, mollis euismod turpis. Nullam malesuada leo quis dui rutrum elementum. Maecenas non est velit.

Quisque eget diam sit amet nisl faucibus venenatis et in dui. Integer metus mi, fringilla a vestibulum non, fringilla sit amet tellus. Pellentesque pretium sem id dui semper viverra. Sed auctor lacinia lorem, in iaculis felis gravida ac. Vestibulum vitae fringilla diam, ut imperdiet felis. Cras vulputate quam id magna sodales efficitur. Interdum et malesuada fames ac ante ipsum primis in faucibus. Curabitur nec fringilla sapien. Phasellus nec dui sed neque lobortis euismod. Donec lobortis nec sem quis consequat. Aenean non dictum magna, nec consequat diam.

Praesent in placerat turpis. Etiam vel interdum nunc, eget pulvinar dolor. Vestibulum dignissim tempor egestas. Cras in dui placerat, imperdiet est non, consequat nisl. Ut vel dui ac neque pellentesque dignissim. Vestibulum ornare tellus purus, eget porttitor est semper vel. Integer ac dictum augue. Phasellus eget gravida dolor. Aliquam euismod mi sem, vel scelerisque nisl vestibulum at. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae; Sed lacinia interdum nisl ultrices iaculis. Ut malesuada augue et sem aliquam pretium non eget nibh. Cras eget placerat ex. Ut dapibus elementum sagittis. Nam ultrices dolor sit amet molestie laoreet. Morbi mattis dictum erat, vel finibus magna dictum sed."

medium_lorem="Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis libero neque, semper ut arcu eget, porta condimentum libero. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Fusce blandit lacinia nunc vel tempus. Cras a risus et tellus blandit vestibulum non at libero. Morbi molestie condimentum convallis. Integer pharetra venenatis nisi, eget tincidunt dolor molestie non. Sed vitae ultricies diam. Duis consectetur sem sed purus vestibulum, et gravida tellus mattis. Duis cursus enim vestibulum, venenatis tellus ut, venenatis nisl. Aenean pretium, ligula at tempus aliquam, sapien orci malesuada mauris, nec tempor augue enim id odio. Vestibulum malesuada odio quis luctus tincidunt. Suspendisse at lorem ullamcorper, suscipit augue quis, viverra leo. Nunc eget lacus ipsum.

Cras ac porttitor velit, id tempus nunc. In gravida, sapien at rhoncus vehicula, ligula nibh sagittis justo, id porta neque sapien id est. Suspendisse molestie erat sed lectus ultrices, at condimentum nibh malesuada. Suspendisse massa tortor, pharetra vitae pellentesque a, laoreet ut ante. Phasellus eu enim ac turpis porttitor sodales. Vivamus urna nibh, hendrerit a mattis sit amet, luctus in orci. Praesent ligula quam, placerat ac lorem eget, eleifend tristique erat. Cras sit amet tellus quam. Pellentesque viverra eu mi quis gravida. Duis ante leo, auctor a leo et, pellentesque efficitur tellus. Nulla facilisi. Nam semper enim nec ante tristique, quis dignissim mauris tempor. Nam nunc tellus, molestie id eros vel, blandit tempus felis. Fusce ultrices blandit metus, ut mollis sem consectetur vitae. Pellentesque vel tempus massa."

short_lorem="Lorem ipsum dolor sit amet, consectetur adipiscing elit."

if [[ "$1" == "" ]]; then
    echo "$medium_lorem"
    exit 0
fi

while getopts "hsml" opt; do
    case "$opt" in
    s)
        echo "$short_lorem"
        ;;
    l)
        echo "$long_lorem"
        ;;
    m)
        echo "$medium_lorem"
        ;;
    h | *)
        echo "$help"
        ;;
    esac
done

# Shift to the next positional parameter after all options are processed
shift $((OPTIND - 1))

# Check for any unexpected arguments
if [ $# -gt 0 ]; then
    echo "Unexpected argument: $1"
    echo "$help"
    exit 1
fi
