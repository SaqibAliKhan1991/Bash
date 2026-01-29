sites=("google.com" "github.com")
for site in "${sites[@]}"; do
    ping -c 1 $site &> /dev/null
    if [ $? -eq 0 ]; then
        echo "$site is UP"
    else
        echo "$site is DOWN"
    fi
done

