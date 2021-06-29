const webpack = require('webpack');
const path = require('path');
const HtmlWebpackPlugin = require('html-webpack-plugin');
const CopyPlugin = require('copy-webpack-plugin');
const CleanWebpackPlugin = require('clean-webpack-plugin');
const Dotenv = require('dotenv-webpack');
const HtmlWebpackInlineSourcePlugin = require('html-webpack-inline-source-plugin');
const MiniCssExtractPlugin = require('mini-css-extract-plugin');

const outputFolder = 'dist/holisticon';
const devMode = process.env.NODE_ENV === 'development';

function copyList(entryPoint, outputFolder) {
  let list = [
      {
          from: path.join(__dirname, `package.json`),
          to: path.join(__dirname, `${outputFolder}`),
      },
      {
          from: path.join(__dirname, `src/templates/${entryPoint}`),
          to: path.join(__dirname, `${outputFolder}/${entryPoint}`),
          ignore: ['*.js', '*.ts', '*.scss'],
      },
  ];
  if (entryPoint != 'email') {
    list = list.concat([
        {
            from: path.join(__dirname, `src/fonts`),
            to: path.join(__dirname, `${outputFolder}/${entryPoint}/resources/fonts`),
        },
        {
            from: path.join(__dirname, `node_modules/patternfly/dist/fonts`),
            to: path.join(__dirname, `${outputFolder}/${entryPoint}/resources/fonts`),
        },
        {
            from: path.join(__dirname, `src/images`),
            to: path.join(__dirname, `${outputFolder}/${entryPoint}/resources/images`),
        },
    ]);
  }
  return list;
}

const commonConfig = (entryPoint) => {
    let config = {
        entry: `./src/templates/${entryPoint}/index.ts`,

        module: {
            rules: [
                {
                    include: [path.resolve(__dirname, 'src/templates')],
                    test: /\.tsx?$/,
                    use: 'ts-loader',
                    exclude: /node_modules/
                },
                {
                    include: [path.resolve(__dirname, 'src/templates')],
                    loader: 'babel-loader',

                    options: {
                        plugins: [
                            'syntax-dynamic-import',
                        ],

                        presets: [
                            [
                                '@babel/preset-env',
                                {
                                    modules: false
                                }
                            ]
                        ]
                    },

                    test: /\.js$/
                },
                {
                    test: /\.ftl$/,
                    loader: "html-loader"
                },
                {
                    test: /\.(jpe?g|png|gif)$/,
                    loader: 'url-loader',
                    options: {
                        // Images larger than 100 KB won’t be inlined
                        limit: 100 * 1024
                    }
                },
                {
                    test: /\.(scss|css)$/,

                    use: [
                        // For production builds it's recommended to extract the CSS from your bundle being able to use parallel loading of CSS/JS resources later on.
                        // This can be achieved by using the mini-css-extract-plugin, because it creates separate css files. For development mode (including webpack-dev-server)
                        // you can use style-loader, because it injects CSS into the DOM using multiple
                        devMode ? 'style-loader' : MiniCssExtractPlugin.loader,
                        {
                            loader: 'css-loader',
                        },
                        {
                            loader: 'resolve-url-loader'
                        },
                        {
                            loader: 'sass-loader',
                            options: {
                                "includePaths": [
                                    require('path').resolve(__dirname, 'node_modules/patternfly/dist/sass'),
                                    require('path').resolve(__dirname, 'node_modules/bootstrap-sass/assets/stylesheets'),
                                    require('path').resolve(__dirname, 'node_modules/font-awesome-sass/assets/stylesheets'),
                                ]
                            },
                        },
                    ]
                },
                {
                    test: /\.(woff(2)?|ttf|eot|svg)(\?v=\d+\.\d+\.\d+)?$/,
                    use: [
                    {
                        loader: 'file-loader',
                        options: {
                        name: '[name].[ext]',
                        outputPath: 'fonts/'
                        }
                    }
                    ]
                }
            ]
        },

        output: {
            filename: 'bundle.js',
            path: path.join(__dirname, `./${outputFolder}/${entryPoint}/resources/js/`),
            publicPath: '${url.resourcesPath}/js/'
        },

        mode: process.env.NODE_ENV || 'development',

        plugins: [
            new CleanWebpackPlugin(),
            new webpack.BannerPlugin({
                banner: () => `Copyright ${new Date().getFullYear()} Holisticon AG`
            }),
            new webpack.EnvironmentPlugin({}),
            new Dotenv(),
        ],

        optimization: {
            splitChunks: {
                cacheGroups: {
                    vendors: {
                        priority: -10,
                        test: /[\\/]node_modules[\\/]/
                    }
                },

                chunks: 'async',
                minChunks: 1,
                minSize: 30000,
                name: true,
            },
            minimizer: [],
        },
    };
    config.plugins.push(
      new CopyPlugin(copyList(entryPoint, outputFolder))
    );
    if (entryPoint == 'email') {
        config.plugins.push(new HtmlWebpackPlugin({
            filename: `../../html/template.ftl`,
            template: `./src/templates/${entryPoint}/html/template.ftl`,
            inject: true,
		    inlineSource: '.(js|css)$' // embed all javascript and css inline
        }));
    } else   {
        config.plugins.push(new HtmlWebpackPlugin({
            filename: `../../template.ftl`,
            template: `./src/templates/${entryPoint}/template.ftl`,
            inject: true,
            inlineSource: '.(css)$' // embed all css inline
        }));
    }
    config.plugins.push(new MiniCssExtractPlugin({
        // Options similar to the same options in webpackOptions.output
        // all options are optional
        filename: '[name].css',
        chunkFilename: '[id].css',
        ignoreOrder: false, // Enable to remove warnings about conflicting order
    }));
    config.plugins.push(new HtmlWebpackInlineSourcePlugin());
    return config;
};

module.exports = ['login', 'account', 'email'].map(res => commonConfig(res));
