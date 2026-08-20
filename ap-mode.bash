read -r -p "Enter ap mode Y/N: " result

sudo apt update && sudo apt install -y dnsmasq

if [[ "$result" =~ ^[Yy]$ ]]; then
    sudo nmcli con add type wifi ifname wlan0 mode ap con-name WIFI_AP ssid BURT
    sudo nmcli con modify WIFI_AP 802-11-wireless.band bg
    sudo nmcli con modify WIFI_AP 802-11-wireless.channel 1
    sudo nmcli con modify WIFI_AP 802-11-wireless-security.key-mgmt none
    sudo nmcli con modify WIFI_AP ipv4.method shared
    sudo nmcli con up WIFI_AP
elif [[ "$result" =~ ^[Nn]$ ]]; then
    sudo nmcli con down WIFI_AP
fi
